function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var weddingAddress = document.getElementById('seating_plan_address');

    if (weddingAddress) {
      var autocomplete = new google.maps.places.Autocomplete(weddingAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(weddingAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
