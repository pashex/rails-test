bookApp.controller('books', ['$scope', '$http', 
  function($scope, $http) {
    $http.get('api/books')
    .success(function(response) {
      $scope.books = response;
    })
    .error(function() {});
  }
]);
