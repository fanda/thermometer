Ractive.components.dynamic = Ractive.extend({
    template: '<component/>',
    components: {
        component: function() {
            return this.get('name');
        }
    },
    oninit: function(){
        this.observe('name', function(){
            this.reset();
        }, { init: false});
    }
});
