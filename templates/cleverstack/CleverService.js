var Q = require('q'),
    BaseService = require( 'services' ).BaseService,
    BASENAMEService;

module.exports = function( sequelize, ORMBASENAMEModel ) {

    if ( BASENAMEService && BASENAMEService.instance ) {
        return BASENAMEService.instance;
    }

    BASENAMEService = require( 'services' ).BaseService.extend( {
        list: function () {

            return [];
        }
    });

    BASENAMEService.instance = new BASENAMEService( sequelize );

    return BASENAMEService.instance;
};
