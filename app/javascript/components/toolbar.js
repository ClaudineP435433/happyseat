function hiddenCouple() {
  const toolbarFormCouple = document.querySelector('.toolbar-form-couple');
  const toolbarFormSingle = document.querySelector('.toolbar-form-one-participant');
  const buttons = document.querySelectorAll('.active-couple');

  buttons.forEach((button) => {
    button.addEventListener('click', () => {
      toolbarFormCouple.classList.toggle('hidden-couple');
      toolbarFormSingle.classList.toggle('hidden-couple');
      buttons.forEach((b) => {
        b.classList.toggle('hidden-couple');
      });
    });
  });
}

export { hiddenCouple };
