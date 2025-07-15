document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".copy-button").forEach((button) => {
    button.addEventListener("click", () => {
      const targetId = button.dataset.target;
      const text = document.getElementById(targetId).innerText;

      navigator.clipboard.writeText(text).then(() => {
        // alert("内容已复制到剪贴板！");
      }).catch(err => {
        // alert("复制失败：" + err);
      });
    });
  });
});
