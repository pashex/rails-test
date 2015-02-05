bookApp.controller('booksIndex', ['$scope', '$location', 'Book', 
  function($scope, $location, Book) {
    $scope.books = Book.query();

    $scope.destroy = function (index){
      Book.remove({id: $scope.books[index].id}, function() {
        $scope.books.splice(index, 1);
      }, function(response) {
        if (response.status == 404) {
          $location.path('/404');
        };
      });
    }
  }
]);

bookApp.controller('booksEdit', ['$scope', '$location', '$routeParams', 'Book',
  function($scope, $location, $routeParams, Book) { 
    $scope.book = Book.get({id: $routeParams.id}, function() {}, function(response) {
      if (response.status == 404) {
        $location.path('/404');
      };
    });

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
