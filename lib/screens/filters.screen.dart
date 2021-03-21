import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  
  final Function saveFilters;
  final Map<String, bool> filters;

  FiltersScreen(
    this.saveFilters,
    this.filters
  );

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FiltersScreen> {
    bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;
  
  @override
  void initState() {
    _glutenFree = widget.filters['gluten'];
    _lactoseFree = widget.filters['lactose'];
    _vegetarian = widget.filters['vegetarian'];
    _vegan = widget.filters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String subTitle,
    bool value,
    Function updateValue
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: value,
      onChanged: updateValue
    );
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Your Favorites'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save
            ),
            onPressed:() {
              final selectedData = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian
              };
              widget.saveFilters(selectedData);
            },
          )
        ]
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline1,
            )
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include Vegetarian meals.',
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include Vegan meals.',
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }
                ),
              ]
            )
          ),
        ]
      )
    );
  }
}