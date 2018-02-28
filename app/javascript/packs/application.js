import "bootstrap";


import { initUpdateNavbarOnScroll } from '../components/navbar';
if (window.location.pathname === "/"){
initUpdateNavbarOnScroll();
}

import { hiddenCouple } from '../components/toolbar';
hiddenCouple();
