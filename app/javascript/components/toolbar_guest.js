const toolbarGuest = document.querySelector('.toolbar-guests');
const toolbarGuestClose = document.querySelector('.toolbar-close');
const chevron = document.getElementById('chevron');

function displayGuest() {
  chevron.addEventListener('click', () => {
    toolbarGuest.classList.remove('hidden-couple');
    chevron.classList.add('hidden-couple');
  });
}

function hiddenGuest() {
  toolbarGuestClose.addEventListener('click', () => {
    toolbarGuest.classList.add('hidden-couple');
    chevron.classList.remove('hidden-couple');
  });
}


export { displayGuest, hiddenGuest };
