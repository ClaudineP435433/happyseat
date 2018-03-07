import "bootstrap";
import '../components/select2';
import '../components/dragula';
import { dragDecorator } from '../components/dragula';



import { initUpdateNavbarOnScroll } from '../components/navbar';
if (window.location.pathname === "/"){
initUpdateNavbarOnScroll();
}

import { hiddenCouple } from '../components/toolbar';
hiddenCouple();
