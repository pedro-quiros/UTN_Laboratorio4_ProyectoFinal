document.addEventListener("DOMContentLoaded", function() {
    const timeElement = document.getElementById("time");

    function updateTime() {
        const now = new Date();
        timeElement.textContent = now.toLocaleTimeString();
    }

    updateTime();
    setInterval(updateTime, 1000);
});
