// Basic interaction logging or future enhancements
document.querySelectorAll('.download-btn').forEach(button => {
  button.addEventListener('click', () => {
    console.log(`Downloading: ${button.getAttribute('href')}`);
  });
});
