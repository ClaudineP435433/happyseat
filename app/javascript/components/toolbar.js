function hiddenCouple() {
  const toolbarFormCouple = document.querySelector('.toolbar-form-couple');
  const toolbarFormSingle = document.querySelector('.toolbar-form-one-participant');
  const button = document.querySelector('.active-couple');

  button.addEventListener('click', () => {
      toolbarFormCouple.classList.remove('hidden-couple');
      toolbarFormSingle.classList.add('hidden-couple');
  });
}

export { hiddenCouple };
