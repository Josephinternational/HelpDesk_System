const API_BASE = "http://localhost/helpdesk/api";

const $ = (s) => document.querySelector(s);

function showAlert(msg, isError = true) {
  const el = $("#alert");
  el.classList.remove("hidden");
  el.style.borderColor = isError ? "#ef4444" : "#334155";
  el.textContent = msg;
}

function setTab(tab) {
  document.querySelectorAll(".tab").forEach(b => b.classList.toggle("active", b.dataset.tab === tab));
  $("#loginForm").classList.toggle("hidden", tab !== "login");
  $("#registerForm").classList.toggle("hidden", tab !== "register");
  $("#alert").classList.add("hidden");
}

document.querySelectorAll(".tab").forEach(btn => {
  btn.addEventListener("click", () => setTab(btn.dataset.tab));
});

$("#loginForm").addEventListener("submit", async (e) => {
  e.preventDefault();
  const fd = new FormData(e.target);
  const body = {
    email: fd.get("email"),
    password: fd.get("password"),
  };

  try {
    const r = await fetch(`${API_BASE}/auth_login.php`, {
      method: "POST",
      headers: {"Content-Type":"application/json"},
      body: JSON.stringify(body)
    });
    const j = await r.json();
    if (!j.ok) return showAlert(j.error || "Login failed");

    localStorage.setItem("token", j.token);
    localStorage.setItem("user", JSON.stringify(j.user));
    window.location.href = "dashboard.html";
  } catch {
    showAlert("Network error. Check Apache is running.");
  }
});

$("#registerForm").addEventListener("submit", async (e) => {
  e.preventDefault();
  const fd = new FormData(e.target);
  const body = {
    full_name: fd.get("full_name"),
    email: fd.get("email"),
    password: fd.get("password"),
  };

  try {
    const r = await fetch(`${API_BASE}/auth_register.php`, {
      method: "POST",
      headers: {"Content-Type":"application/json"},
      body: JSON.stringify(body)
    });
    const j = await r.json();
    if (!j.ok) return showAlert(j.error || "Register failed");
    showAlert("Account created. Now login.", false);
    setTab("login");
  } catch {
    showAlert("Network error. Check Apache is running.");
  }
});

// Default
setTab("login");
