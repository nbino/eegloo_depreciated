/*
 * Ext JS Library 2.0.1
 * Copyright(c) 2006-2008, Ext JS, LLC.
 * licensing@extjs.com
 * 
 * http://extjs.com/license
 */

Ext.onReady(function(){
    // shorthand alias
    var fm2 = Ext.form;
    
    // custom column plugin example
    var checkColumn = new Ext.grid.CheckColumn({
       dataIndex: 'selected',
       width: 55
    });
    
    // the column model has information about grid columns
    // dataIndex maps the column to the specific data field in
    // the data store (created below)
    var cm2 = new Ext.grid.ColumnModel([{
           id:'name',
           dataIndex: 'name',
           width: 150,
           editor: new fm2.TextField({
               allowBlank: true
           })
   		},
   		{
           id:'email',
           dataIndex: 'email',           
           width: 200,
           editor: new fm2.TextField({
               allowBlank: true
           })
   		},
        checkColumn
    ]);

    // by default columns are sortable
    cm2.defaultSortable = true;

    // this could be inline, but we want to define the Plant record
    // type so we can add records dynamically
    var Person2 = Ext.data.Record.create([
           // the "name" below matches the tag name to read, except "availDate"
           // which is mapped to the tag "availability"
           {name: 'name', type: 'string'},
		   {name: 'email', type: 'string'},
           {name: 'selected', type: 'bool'}
      ]);

    // create the Data Store
    var store2 = new Ext.data.Store({

        // the return will be XML, so lets set up a reader
        // reader: new Ext.data.XmlReader({
        //        // records will have a "plant" tag
        //        record: 'plant'
        //    }, Plant),

        sortInfo:{field:'name', direction:'ASC'}
    });
    
	
	store2.add(new Person2({name: 'John', email: 'john@doe.com', selected: true}));
	store2.add(new Person2({name: 'John', email: 'john@doe.com', selected: true}));
	store2.add(new Person2({name: 'John', email: 'john@doe.com', selected: true}));
	
    // create the editor grid
    var grid = new Ext.grid.EditorGridPanel({
        store: store2,
        cm: cm2,
        renderTo: 'editor-grid2',
        sm : new Ext.grid.RowSelectionModel({
	            singleSelect : true
        }),
        header:false,
        hideBorders: true,
        width:450,
        height:200,
        frame:false,
        plugins:checkColumn,
        clicksToEdit:1
    });

    // trigger the data store load
    // store.load();
});

Ext.grid.CheckColumn = function(config){
    Ext.apply(this, config);
    if(!this.id){
        this.id = Ext.id();
    }
    this.renderer = this.renderer.createDelegate(this);
};

Ext.grid.CheckColumn.prototype ={
    init : function(grid){
    	
        this.grid = grid;
        this.grid.on('render', function(){
            var view = this.grid.getView();
            view.mainBody.on('mousedown', this.onMouseDown, this);
        }, this);
    },

    onMouseDown : function(e, t){

        if(t.className && t.className.indexOf('x-grid3-cc-'+this.id) != -1){
            e.stopEvent();
            var index = this.grid.getView().findRowIndex(t);
            var record = this.grid.store.getAt(index);
            record.set(this.dataIndex, !record.data[this.dataIndex]);
        }
    },

    renderer : function(v, p, record){
        //p.css += ' x-grid3-check-col-td'; 
        
        return '<div class="x-grid3-cc-'+this.id+'">'+ '[ '+ (v?'x':'&nbsp;') +' ]'  + '</div>';
        
        //return '<div class="x-grid3-check-col'+(v?'-on':'')+' x-grid3-cc-'+this.id+'">&#160;';
    }
};

