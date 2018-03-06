
import dragula from 'dragula';

const updateSeatParticipant = (element, source) => {
  console.log(element);
  console.log(source.getAttribute("id").split("-")[1]);
  const token = document.querySelector('[name="csrf-token"]').getAttribute('content');
  fetch(element.dataset.path, {
    method: 'PUT',
    headers: {
      "Content-Type": "application/json",
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-Token': token
    },
    body: JSON.stringify({ seat: source.getAttribute("id").split("-")[1] }),
    credentials: 'same-origin'
  })
}

const dragDecorator = (containers, options, transitZone) => {
  const dragulaConst = dragula( containers, options);
  dragulaConst.on('drop', (el, target, source, sibling) => {
    if (transitZone !== target && target.children.length > 1) {
      const element = (sibling !== null) ? sibling : el;
      if (sibling !== null) {
        console.log(sibling !== null);
        updateSeatParticipant(el, target);
      }
      updateSeatParticipant(element, source);
      element.classList.remove("gu-transit");
      source.insertAdjacentHTML("beforeend", element.outerHTML);
      element.remove();
        console.log("coco");
    } else {
        updateSeatParticipant(el, target);
    }
  });
};


let seatIndex = 0

const area = document.querySelector('#drop-zone');

let containers = [area]

document.querySelectorAll('.avatar').forEach((table) => {
  let seats = document.querySelector(`#avatar-${seatIndex}`);
  containers.push(seats);
  seatIndex += 1;
 });

const options = { };
dragDecorator(containers, options, area);


import 'dragula/dist/dragula.css';

export { dragDecorator };
