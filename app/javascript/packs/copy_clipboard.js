import ClipboardJS from "clipboard/dist/clipboard";

const btn = document.getElementById('clipboard-btn');
const clipboard = new ClipboardJS(btn);

clipboard.on('success', function (e) {
    alert('Copied!');
});
// Error
clipboard.on('error', function (e) {
    console.log(e);
});