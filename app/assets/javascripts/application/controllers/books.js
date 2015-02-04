bookApp.controller('booksIndex', ['$scope', 'Book', 
  function($scope, Book) {
    $scope.books = Book.query();
  }
]);

bookApp.controller('booksEdit', ['$scope', '$location', '$routeParams', 'Book',
  function($scope, $location, $routeParams, Book) { 
    $scope.book = Book.get({id: $routeParams.id});

    $scope.save = function() {
      $scope.book.$update(function() {
        $location.path('/books');
      },
      function(response) {
        $scope.errors = response.data;
      });
    }
  }
]);

bookApp.controller('booksCreate', ['$scope', '$location', 'Book',
  function($scope, $location, Book) {
    $scope.book = new Book({name: ''});

    $scope.save = function() {
      $scope.book.$save(function() {
        $location.path('/books');
      },
      function(response) {
        $scope.errors = response.data;
      });
    }
  }
]);
