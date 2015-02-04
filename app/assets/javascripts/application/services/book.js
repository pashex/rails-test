bookApp.factory('Book', ['$resource', function($resource) {
  return $resource('api/books/:id', {id: '@id'}, {
    'update': { method:'PATCH' }
  });
}]);
