
const API_BASE = "http://localhost/helpdesk/api";
const token = localStorage.getItem("token");

const qs = (s) => document.querySelector(s);

function authHeaders() {
  return { "Content-Type":"application/json", "Authorization": `Bearer ${token}` };
}

function goLogin() {
  localStorage.removeItem("token");
  localStorage.removeItem("user");
  window.location.href = "index.html";
}

async function apiGet(path) {
  const r = await fetch(`${API_BASE}/${path}`, { headers: authHeaders() });
  const j = await r.json();
  if (!j.ok && (r.status === 401 || r.status === 403)) goLogin();
  return j;
}
async function apiPost(path, body) {
  const r = await fetch(`${API_BASE}/${path}`, { method:"POST", headers: authHeaders(), body: JSON.stringify(body) });
  const j = await r.json();
  if (!j.ok && (r.status === 401 || r.status === 403)) goLogin();
  return j;
}

function badge(text){ return `<span class="badge">${text}</span>`; }

function ticketRow(t){
  return `
    <tr>
      <td>${t.ticket_no}</td>
      <td>${t.title}</td>
      <td>${badge(t.category)}</td>
      <td>${badge(t.priority)}</td>
      <td>${badge(t.status)}</td>
      <td>${t.technician ? t.technician : "-"}</td>
      <td><button class="btn" data-open="${t.id}">Open</button></td>
    </tr>
  `;
}

function setNav(items){
  const nav = qs("#nav");
  nav.innerHTML = "";
  items.forEach(it=>{
    const b = document.createElement("button");
    b.textContent = it.label;
    b.addEventListener("click", ()=> openPage(it));
    nav.appendChild(b);
    it._btn = b;
  });
  openPage(items[0]);
}

function setActiveBtn(items, active){
  items.forEach(i => i._btn.classList.toggle("active", i.key === active.key));
}

function setTitle(t){ qs("#pageTitle").textContent = t; }

function page(html){ qs("#pageArea").innerHTML = html; }

async function openPage(p){
  const items = window.__navItems || [];
  setActiveBtn(items, p);
  setTitle(p.label);
  await p.render();
}

/* PAGES */
async function renderMyTickets(){
  const data = await apiGet("tickets_list.php");
  page(`
    <div class="grid">
      <div class="col-12 card">
        <div class="row">
          <input id="q" placeholder="Search ticket no or title..." />
          <select id="status">
            <option value="">All status</option>
            <option>open</option><option>assigned</option><option>in_progress</option><option>resolved</option><option>closed</option>
          </select>
          <button class="btn" id="filterBtn">Filter</button>
          <button class="btn primary" id="newBtn">New Ticket</button>
        </div>
        <div style="overflow:auto;margin-top:10px">
          <table class="table">
            <thead><tr>
              <th>Ticket No</th><th>Title</th><th>Category</th><th>Priority</th><th>Status</th><th>Technician</th><th></th>
            </tr></thead>
            <tbody id="tb">${data.tickets.map(ticketRow).join("")}</tbody>
          </table>
        </div>
      </div>
    </div>
  `);

  qs("#filterBtn").onclick = async ()=>{
    const q = qs("#q").value.trim();
    const s = qs("#status").value.trim();
    const res = await apiGet(`tickets_list.php?q=${encodeURIComponent(q)}&status=${encodeURIComponent(s)}`);
    qs("#tb").innerHTML = res.tickets.map(ticketRow).join("");
    wireOpenButtons();
  };

  qs("#newBtn").onclick = renderCreateTicket;
  wireOpenButtons();
}

async function renderCreateTicket(){
  const cats = await apiGet("categories_list.php");
  page(`
    <div class="grid">
      <div class="col-12 card">
        <h2 style="margin-top:0">Create Ticket</h2>
        <div id="msg" class="alert hidden"></div>
        <div class="row">
          <select id="cat">
            ${cats.categories.map(c=>`<option value="${c.id}">${c.name}</option>`).join("")}
          </select>
          <select id="prio">
            <option value="low">Low</option>
            <option value="medium" selected>Medium</option>
            <option value="high">High</option>
          </select>
        </div>
        <div style="margin-top:10px">
          <input id="title" placeholder="Short title" />
          <textarea id="desc" placeholder="Describe the problem clearly..."></textarea>
          <div class="row">
            <button class="btn" id="backBtn">Back</button>
            <button class="btn primary" id="saveBtn">Submit</button>
          </div>
        </div>
      </div>
    </div>
  `);

  const msg = qs("#msg");
  const show = (t, ok=false)=>{
    msg.classList.remove("hidden");
    msg.style.borderColor = ok ? "#334155" : "#ef4444";
    msg.textContent = t;
  };

  qs("#backBtn").onclick = renderMyTickets;
  qs("#saveBtn").onclick = async ()=>{
    const body = {
      category_id: qs("#cat").value,
      priority: qs("#prio").value,
      title: qs("#title").value.trim(),
      description: qs("#desc").value.trim()
    };
    if(!body.title || !body.description) return show("Please fill title and description");

    const res = await apiPost("tickets_create.php", body);
    if(!res.ok) return show(res.error || "Failed");
    show(`Ticket submitted: ${res.ticket_no}`, true);
    setTimeout(renderMyTickets, 900);
  };
}

async function renderAssignedTickets(){
  const data = await apiGet("tickets_list.php");
  page(`
    <div class="grid">
      <div class="col-12 card">
        <h2 style="margin-top:0">Assigned Tickets</h2>
        <div style="overflow:auto;margin-top:10px">
          <table class="table">
            <thead><tr>
              <th>Ticket No</th><th>Title</th><th>Category</th><th>Priority</th><th>Status</th><th></th>
            </tr></thead>
            <tbody id="tb">
              ${data.tickets.map(t=>`
                <tr>
                  <td>${t.ticket_no}</td>
                  <td>${t.title}</td>
                  <td>${badge(t.category)}</td>
                  <td>${badge(t.priority)}</td>
                  <td>${badge(t.status)}</td>
                  <td><button class="btn" data-open="${t.id}">Open</button></td>
                </tr>
              `).join("")}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  `);
  wireOpenButtons();
}

async function renderAdminPanel(){
  const tickets = await apiGet("tickets_list.php");
  const techs = await apiGet("technicians_list.php");

  page(`
    <div class="grid">
      <div class="col-12 card">
        <h2 style="margin-top:0">Admin: Assign Tickets</h2>
        <p class="muted">Select a ticket, then assign to a technician.</p>

        <div class="row">
          <select id="ticketSel">
            ${tickets.tickets.map(t=>`<option value="${t.id}">${t.ticket_no} - ${t.title}</option>`).join("")}
          </select>
          <select id="techSel">
            ${techs.technicians.map(u=>`<option value="${u.id}">${u.full_name}</option>`).join("")}
          </select>
          <button class="btn primary" id="assignBtn">Assign</button>
        </div>

        <div id="msg" class="alert hidden" style="margin-top:10px"></div>

        <div style="overflow:auto;margin-top:12px">
          <table class="table">
            <thead><tr>
              <th>Ticket</th><th>Title</th><th>Status</th><th>Technician</th><th></th>
            </tr></thead>
            <tbody>
              ${tickets.tickets.map(t=>`
                <tr>
                  <td>${t.ticket_no}</td>
                  <td>${t.title}</td>
                  <td>${badge(t.status)}</td>
                  <td>${t.technician || "-"}</td>
                  <td><button class="btn" data-open="${t.id}">Open</button></td>
                </tr>
              `).join("")}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  `);

  const msg = qs("#msg");
  const show = (t, ok=false)=>{
    msg.classList.remove("hidden");
    msg.style.borderColor = ok ? "#334155" : "#ef4444";
    msg.textContent = t;
  };

  qs("#assignBtn").onclick = async ()=>{
    const res = await apiPost("tickets_assign.php", {
      ticket_id: qs("#ticketSel").value,
      technician_id: qs("#techSel").value
    });
    if(!res.ok) return show(res.error || "Assign failed");
    show("Assigned successfully", true);
    setTimeout(renderAdminPanel, 700);
  };

  wireOpenButtons();
}

async function renderReports(){
  const today = new Date().toISOString().slice(0,10);
  page(`
    <div class="grid">
      <div class="col-12 card">
        <h2 style="margin-top:0">Reports</h2>
        <div class="row">
          <input type="date" id="from" value="${today.slice(0,8)}01" />
          <input type="date" id="to" value="${today}" />
          <button class="btn primary" id="runBtn">Run</button>
        </div>
        <div id="out" style="margin-top:12px"></div>
      </div>
    </div>
  `);

  qs("#runBtn").onclick = async ()=>{
    const from = qs("#from").value;
    const to = qs("#to").value;
    const r = await apiGet(`reports_summary.php?from=${encodeURIComponent(from)}&to=${encodeURIComponent(to)}`);
    const out = qs("#out");
    out.innerHTML = `
      <h3>By Status</h3>
      <div class="row">${r.by_status.map(x=>`<div class="card" style="padding:10px">${badge(x.status)}<div style="font-size:1.6rem;font-weight:900">${x.total}</div></div>`).join("")}</div>
      <h3>By Technician</h3>
      <div style="overflow:auto">
        <table class="table">
          <thead><tr><th>Technician</th><th>Assigned Tickets</th></tr></thead>
          <tbody>
            ${r.by_technician.map(x=>`<tr><td>${x.technician}</td><td>${x.assigned_count}</td></tr>`).join("")}
          </tbody>
        </table>
      </div>
    `;
  };
}

async function renderTicketDetail(id){
  const t = await apiGet(`tickets_view.php?id=${id}`);
  const role = window.__me.role;

  page(`
    <div class="grid">
      <div class="col-12 card">
        <button class="btn" id="backBtn">← Back</button>
        <h2 style="margin:10px 0 0 0">${t.ticket.ticket_no} - ${t.ticket.title}</h2>
        <p class="muted">Category: <b>${t.ticket.category}</b> | Priority: <b>${t.ticket.priority}</b> | Status: <b>${t.ticket.status}</b></p>

        <div class="card" style="padding:12px;margin:10px 0">
          <b>Description</b>
          <p style="white-space:pre-wrap;margin:8px 0 0 0">${t.ticket.description}</p>
        </div>

        ${(role === "technician" || role === "admin") ? `
          <div class="row">
            <select id="newStatus">
              <option ${t.ticket.status==="open"?"selected":""}>open</option>
              <option ${t.ticket.status==="assigned"?"selected":""}>assigned</option>
              <option ${t.ticket.status==="in_progress"?"selected":""}>in_progress</option>
              <option ${t.ticket.status==="resolved"?"selected":""}>resolved</option>
              <option ${t.ticket.status==="closed"?"selected":""}>closed</option>
            </select>
            <button class="btn primary" id="statusBtn">Update Status</button>
          </div>
        ` : ""}

        <div class="card" style="padding:12px;margin-top:12px">
          <b>Comments</b>
          <div id="comments" style="margin-top:10px"></div>

          <div style="margin-top:10px">
            <textarea id="msg" placeholder="Write a comment..."></textarea>
            <button class="btn primary" id="sendBtn">Send</button>
            <div id="note" class="muted small" style="margin-top:6px"></div>
          </div>
        </div>
      </div>
    </div>
  `);

  qs("#backBtn").onclick = ()=> {
    if(role==="admin") renderAdminPanel();
    else if(role==="technician") renderAssignedTickets();
    else renderMyTickets();
  };

  async function loadComments(){
    const r = await apiGet(`comments_list.php?ticket_id=${id}`);
    qs("#comments").innerHTML = r.comments.map(c=>`
      <div class="card" style="padding:10px;margin:8px 0">
        <div class="muted small"><b>${c.full_name}</b> (${c.role}) • ${c.created_at}</div>
        <div style="white-space:pre-wrap;margin-top:6px">${c.message}</div>
      </div>
    `).join("") || `<div class="muted">No comments yet.</div>`;
  }
  await loadComments();

  if (qs("#statusBtn")) {
    qs("#statusBtn").onclick = async ()=>{
      const res = await apiPost("tickets_status.php", { ticket_id: id, status: qs("#newStatus").value });
      qs("#note").textContent = res.ok ? "Status updated." : (res.error || "Failed");
      if(res.ok) setTimeout(()=>renderTicketDetail(id), 500);
    };
  }

  qs("#sendBtn").onclick = async ()=>{
    const msg = qs("#msg").value.trim();
    if(!msg) return;
    const res = await apiPost("comments_add.php", { ticket_id: id, message: msg });
    qs("#note").textContent = res.ok ? "Comment sent." : (res.error || "Failed");
    if(res.ok){
      qs("#msg").value = "";
      await loadComments();
    }
  };
}

function wireOpenButtons(){
  document.querySelectorAll("[data-open]").forEach(b=>{
    b.onclick = ()=> renderTicketDetail(b.getAttribute("data-open"));
  });
}

/* SIDEBAR MOBILE */
qs("#openSidebar").onclick = ()=> qs("#sidebar").classList.add("open");
qs("#closeSidebar").onclick = ()=> qs("#sidebar").classList.remove("open");

/* LOGOUT */
qs("#logoutBtn").onclick = async ()=>{
  try { await fetch(`${API_BASE}/auth_logout.php`, { method:"POST", headers: authHeaders() }); } catch {}
  goLogin();
};

/* INIT */
(async function init(){
  if(!token) return goLogin();

  const meRes = await apiGet("me.php");
  if(!meRes.ok) return goLogin();
  window.__me = meRes.user;

  qs("#userPill").textContent = meRes.user.full_name;
  qs("#roleBadge").textContent = meRes.user.role.toUpperCase();

  let navItems = [];
  if (meRes.user.role === "user") {
    navItems = [
      { key:"myTickets", label:"My Tickets", render: renderMyTickets },
      { key:"newTicket", label:"Create Ticket", render: renderCreateTicket },
    ];
  } else if (meRes.user.role === "technician") {
    navItems = [
      { key:"assigned", label:"Assigned Tickets", render: renderAssignedTickets },
    ];
  } else { // admin
    navItems = [
      { key:"adminAssign", label:"Assign Tickets", render: renderAdminPanel },
      { key:"reports", label:"Reports", render: renderReports },
    ];
  }

  window.__navItems = navItems;
  setNav(navItems);
})();

document.addEventListener("DOMContentLoaded", () => {

  const toggleBtn = document.getElementById("themeToggle");

  if (!toggleBtn) return;

  // load saved theme
  const savedTheme = localStorage.getItem("theme");

  if (savedTheme === "dark") {
    document.body.classList.add("dark");
    toggleBtn.textContent = "☀️ Light";
  } else {
    toggleBtn.textContent = "🌙 Dark";
  }

  toggleBtn.addEventListener("click", () => {

    document.body.classList.toggle("dark");

    const isDark = document.body.classList.contains("dark");

    localStorage.setItem("theme", isDark ? "dark" : "light");

    toggleBtn.textContent = isDark ? "☀️ Light" : "🌙 Dark";
  });

});