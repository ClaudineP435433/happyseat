
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
  });
};

document.querySelectorAll('.table-card').forEach((table) => {
  let table_nb_top = document.querySelector(`#table-top-${seatIndex}`);
  containers.push(table_nb_top);
  let table_nb_bottom = document.querySelector(`#table-bottom-${seatIndex}`);
  containers.push(table_nb_bottom);
  seatIndex += 1;
 });

const options = { };
dragDecorator(containers, options);

import 'dragula/dist/dragula.css';


// -----------------

// const dragDecorator = (containers, options, transitZone) => {
//   const dragulaConst = dragula( containers, options);
//   dragulaConst.on('drop', (el, target, source, sibling) => {
//     if (transitZone !== target && target.children.length > 1) {
//       const element = sibling ? sibling : el;
//       element.classList.remove("gu-transit")
//       source.insertAdjacentHTML("beforeend", element.outerHTML);
//       element.remove();
//     }
//   });
// };

// const top = document.querySelector('#top');
// const containers = [
//   top,
//   document.querySelector('#left'),
//   document.querySelector('#center-left'),
//   document.querySelector('#center-right'),
//   document.querySelector('#right')
// ];
// const options = { };
// dragDecorator(containers, options, top)

