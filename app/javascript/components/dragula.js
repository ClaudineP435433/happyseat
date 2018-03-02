
import dragula from 'dragula';
let index = 0
let list = []

  document.querySelectorAll('.table-section').forEach(() {
      let table = document.querySelector(`#table-${index}`);
      list.push(table);
      index += 1;
    });

dragula(list);

import 'dragula/dist/dragula.css';
