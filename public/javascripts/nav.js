var list = $$('#menuul li');
list.each(function(element) {

	var fx = new Fx.Styles(element, {duration:200, wait:false});

	element.addEvent('mouseenter', function(){
		fx.start({
			'padding-top': 30,
			'background-color': '#666',
			color: '#FFFFFF'
		});
	});

	element.addEvent('mouseleave', function(){
		fx.start({
			'padding-top': 7,
			'background-color': '#b31b1b',
			'color': '#FFF'
		});
	});

	});