function autocompleteStart() {
  document.addEventListener("DOMContentLoaded", function() {
    var loginAddress = document.getElementById('start');

    if (loginAddress) {
      var autocompleteStart = new google.maps.places.Autocomplete(loginAddress, { types: [ 'geocode' ] });
      google.maps.event.addDomListener(loginAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocompleteStart };
