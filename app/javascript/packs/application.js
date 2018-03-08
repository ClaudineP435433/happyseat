import "bootstrap";
import '../components/autocomplete';
import '../components/autocomplete_start';
import '../components/select2';
import '../components/avatar_details';
import '../components/dragula';
import { dragDecorator } from '../components/dragula';



import { initUpdateNavbarOnScroll } from '../components/navbar';
if (window.location.pathname === "/"){
initUpdateNavbarOnScroll();
}

import { hiddenCouple } from '../components/toolbar';
hiddenCouple();
