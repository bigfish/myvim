describe('<+MODULE+>', function () {
  'use strict';

  var mod;

  beforeEach(function (done) {
    //use requirejs to prevent conflict with node require
    requirejs(['<+MOD+>'], function (_mod) {
      mod = _mod;
      done();
    });
  });

});
