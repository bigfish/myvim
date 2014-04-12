module.exports = function( BASENAMEService ) {
    return (require('classes').Controller).extend(
    {
        service: BASENAMEService
    },
    {

        listAction: function() {
            this.send( BASENAMEService.list() );
        },

        customAction: function() {
            this.send({
                message: "Hello from customAction inside BASENAMEController"
            });
        }

    });
};
