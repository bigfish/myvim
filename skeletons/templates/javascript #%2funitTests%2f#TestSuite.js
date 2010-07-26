YUI.add('<+TestSuiteName+>', function (Y) {

    var suite = new Y.Test.Suite("TestSuiteTitle");

    suite.add(new Y.Test.Case({
        name : "<+TestCaseTitle+>",

        setUp : function () { <++>
        },

        tearDown : function () { <++>
        },

        "test<++>": function () {
            Y.Assert.isTrue(1);
        }

    }));

    Y.Test.Runner.add(suite);

},
'@VERSION@', {
    requires : ['test']
});

