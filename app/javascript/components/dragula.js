
import dragula from 'dragula';
let index = 0
let list = []

document.querySelectorAll('.table-card').forEach((table) => {
  let table_nb_top = document.querySelector(`#table-top-${index}`);
  list.push(table_nb_top);
  let table_nb_bottom = document.querySelector(`#table-bottom-${index}`);
  list.push(table_nb_bottom);
  index += 1;
 });


const area = document.querySelector('#drop-zone');
list.push(area);


dragula(list);

import 'dragula/dist/dragula.css';
