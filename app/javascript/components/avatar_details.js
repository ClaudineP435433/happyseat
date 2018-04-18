const searchForm = document.getElementById('search-form');
// seats = que les sieges --> impossible de double clicker sur avatar dans la dropzone
const seats = document.querySelectorAll(".avatar");
seats.forEach((seat) => {
  seat.addEventListener("dblclick", (event) => {
    const avatar = seat.querySelector('.avatar-participant');
    if (avatar) {
      const inputParticipant = document.getElementById('search_participant_id');
      // inputParticipant.setAttribute("value", "");
      const participantId = avatar.dataset.pid;

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
      // avatars = document.querySelectorAll('.avatar-participant');
      submit.click();
    }
  });
});
