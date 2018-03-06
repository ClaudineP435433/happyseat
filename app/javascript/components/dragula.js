
import dragula from 'dragula';

let seatIndex = 0

const area = document.querySelector('#drop-zone');

let containers = [area]

const dragDecorator = (containers, options, transitZone) => {
  const dragulaConst = dragula( containers, options);
  dragulaConst.on('drop', (el, target, source, sibling) => {
    if (transitZone !== target && target.children.length > 1) {
      const element = sibling ? sibling : el;
      element.classList.remove("gu-transit");
      source.insertAdjacentHTML("beforeend", element.outerHTML);
      element.remove();
    }
    console.log("coco");
  });
};

document.querySelectorAll('.avatar').forEach((table) => {
  let seats = document.querySelector(`#avatar-${seatIndex}`);
  containers.push(seats);
  seatIndex += 1;
 });

const options = { };
dragDecorator(containers, options, area);

import 'dragula/dist/dragula.css';
