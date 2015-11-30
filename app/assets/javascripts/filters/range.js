var app = angular.module('diagnoseDiseases');

app.filter('range', function() {
    return function(input, min, max) {
        min = parseInt(min);
        max = parseInt(max);
        for (var i=max; i>min; i--)
            input.push(i);
        return input;
    };
});