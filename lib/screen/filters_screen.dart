import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const route = '/filters';
  final Map<String,bool> currentFilters;
  final Function filterFunction;

  FiltersScreen(this.currentFilters,this.filterFunction);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;
  
  @override
  initState(){
    _glutenFree=widget.currentFilters['gluten'];
    _lactoseFree=widget.currentFilters['lactose'];
    _vegetarian=widget.currentFilters['vegetarian'];
    _vegan=widget.currentFilters['vegan'];
   
   
    super.initState();
  }

  Widget _buildTile(
      String title, String subtitle, bool currentVal, Function handler) {
    return SwitchListTile(
      title: Text(title),
      value: currentVal,
      onChanged: handler,
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilter = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegetarian': _vegetarian,
                  'vegan': _vegan
                };
                widget.filterFunction(selectedFilter);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'YOUR FILTERS',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildTile(
                      "Gluten-Free", "includes gluten free meals", _glutenFree,
                      (newVal) {
                    setState(() {
                      _glutenFree = newVal;
                    });
                  }),
                  _buildTile("Lactose-Free", "includes lactose free meals",
                      _lactoseFree, (newVal) {
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  }),
                  _buildTile("Vegetarian", "includes vegetarian meals only",
                      _vegetarian, (newVal) {
                    setState(() {
                      _vegetarian = newVal;
                    });
                  }),
                  _buildTile("Vegan", "includes Vegan meals only", _vegan,
                      (newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  }),
                ],
              ),
            )
          ],
        ));
  }
}
