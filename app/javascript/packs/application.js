import "bootstrap";
import '../components/select2';


import { initUpdateNavbarOnScroll } from '../components/navbar';
if (window.location.pathname === "/"){
initUpdateNavbarOnScroll();
}

import { hiddenCouple } from '../components/toolbar';
hiddenCouple();
