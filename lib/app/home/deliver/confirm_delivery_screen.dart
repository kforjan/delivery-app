import 'package:delivery_app/app/home/deliver/deliver_model.dart';
import 'package:delivery_app/app/home/models/order.dart';
import 'package:delivery_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ConfirmDeliveryScreen extends StatefulWidget {
  const ConfirmDeliveryScreen({
    Key key,
    @required this.order,
    @required this.model,
  }) : super(key: key);

  final Order order;
  final DeliverModel model;

  @override
  _ConfirmDeliveryScreenState createState() => _ConfirmDeliveryScreenState();
}

class _ConfirmDeliveryScreenState extends State<ConfirmDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    var geolocator = Geolocator();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    geolocator.getPositionStream(locationOptions).listen((event) {
      widget.model.updatePosition(event);
      if (widget.model.order != null) {
        Provider.of<Database>(context, listen: false)
            .updateCurrentOrderLocation(widget.model.order, event);
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.accentColor,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        color: theme.accentColor,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              child: Container(
                height: mediaQuery.size.height * 0.3,
                width: mediaQuery.size.width * 0.95,
                child: buildMap(
                  context,
                  Position(
                    latitude: widget.order.latitude,
                    longitude: widget.order.longitude,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.1,
            ),
            _buildOrderCountInfo(),
            SizedBox(
              height: mediaQuery.size.height * 0.27,
            ),
            _buildSubmitButton(context),
            SizedBox(
              height: 10,
            ),
            Opacity(
              opacity: 0.4,
              child: Text(
                widget.order.isActive
                    ? '*the user will be notified that the order has arrived'
                    : '*user will be able to track your location after starting the delivery',
                style: TextStyle(fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCountInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Main meals: ${widget.order.mealCount}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          'Side meals: ${widget.order.sideMealCount}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          'Drinks: ${widget.order.drinkCount}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    if (widget.model.order != null) {
      if (widget.model.order.id != widget.order.id &&
          widget.model.isActiveDelivery) {
        return Text('You alredy started another delivery.');
      }
    }
    return widget.order.isActive
        ? RaisedButton(
            color: Theme.of(context).hintColor,
            child: Text(
              'FINISH DELIVERY',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
            onPressed: () {
              widget.model.updateOrder(null);
              widget.model.toggleIsActiveDelivery();
              Navigator.pop(context);
            },
          )
        : RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              'START DELIVERY',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
            onPressed: () async {
              await Provider.of<Database>(context, listen: false)
                  .updateDeliveryStatus(widget.order);
              setState(() {
                widget.order.isActive = true;
                widget.model.updateOrder(widget.order);
                widget.model.toggleIsActiveDelivery();
                Provider.of<Database>(context, listen: false)
                    .updateCurrentOrderLocation(
                        widget.order, widget.model.position);
              });
            },
          );
  }

  Widget buildMap(BuildContext context, Position position) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(position.latitude, position.longitude),
        zoom: 13.5,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(
                position.latitude,
                position.longitude,
              ),
              builder: (ctx) => Container(
                child: Icon(
                  Icons.my_location,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
