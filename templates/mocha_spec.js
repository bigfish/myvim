define([], function () {
    describe('MODULE', function () {

        beforeEach(function (done) {
            this.mockDeps('MODULE', done);

            //require new module 
            require(['custom_controls/MODULE']); 

            //clear out scaffold area
            $('#scaffold').html('');
        });

        afterEach(function () {

            this.unMockDeps();

            this.MODULE = undefined;

            require.undef('custom_controls/MODULE');
             
        });

        it('should export the Control', function () {
            expect(this.MODULE).to.be.a('function');
        });

    });
});
