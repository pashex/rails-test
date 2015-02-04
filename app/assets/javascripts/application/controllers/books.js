bookApp.controller('books', ['$scope', 'Book', 
  function($scope, Book) {
    $scope.books = Book.query();
  }
]);
