const searchForm = document.getElementById('search-form');
const selectParticipant = document.getElementById('search_participant_id');





const avatars = document.querySelectorAll('.avatar-participant');
avatars.forEach((avatar) => {
  avatar.addEventListener("dblclick", (event) => {
    const inputParticipant = document.getElementById('search_participant_id');
    inputParticipant.setAttribute("value", "");
    const participantId = event.currentTarget.dataset.pid;

    const selected = searchForm.querySelector('option[selected]');

    if (selected) {
      selected.removeAttribute("selected");
    }

    const options = searchForm.querySelectorAll('option');
    options.forEach((option) => {
      const valueOption = option.getAttribute("value");

      if (valueOption === participantId) {
        option.setAttribute("selected", "");
      }

    });
    const submit = document.getElementById('submit-form');
    submit.click();
  });
});
