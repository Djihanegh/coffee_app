import 'package:coffee_app/coffee.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 300);

class CoffeeConceptList extends StatefulWidget {
  @override
  _CoffeeConceptListState createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  final _coffeePageController = PageController(viewportFraction: 0.35);
  final _pageTextController = PageController();
  double _currentPage = 0.0;
  double _textPage = 0.0;
  void _coffeeScrollListener() {
    setState(() {
      _currentPage = _coffeePageController.page!;
    });
  }

  void _textScrollListener() {
    setState(() {
      _textPage = _currentPage;
    });
  }

  @override
  void initState() {
    _coffeePageController.addListener(_coffeeScrollListener);
    _pageTextController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _coffeePageController.removeListener(_coffeeScrollListener);
    _pageTextController.removeListener(_textScrollListener);

    _coffeePageController.dispose();
    _pageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          Positioned(
              left: 20,
              right: 20,
              height: size.height * 0.3,
              bottom: -size.height * 0.22,
              child: DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.brown,
                    blurRadius: 90,
                    spreadRadius: 45,
                  )
                ]),
              )),
          Transform.scale(
              scale: 1.6,
              alignment: Alignment.bottomCenter,
              child: PageView.builder(
                  controller: _coffeePageController,
                  scrollDirection: Axis.vertical,
                  itemCount: coffees.length,
                  onPageChanged: (value) {
                    if (value < coffees.length) {
                      _pageTextController.animateToPage(value,
                          duration: _duration, curve: Curves.easeOut);
                    }
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return SizedBox.shrink();
                    }
                    final coffee = coffees[index];
                    final result = _currentPage - index + 1;
                    final value = -0.4 * result + 1;
                    final opacity = value.clamp(0.0, 1.0);
                    return Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..translate(
                                0.0, size.height / 2.6 * (1 - value).abs())
                            ..scale(value),
                          child: Opacity(
                            opacity: opacity,
                            child: Image.asset(coffee.image),
                          ),
                        ));
                  })),
          Positioned(
            child: Column(children: [
              Expanded(
                child: PageView.builder(
                    controller: _pageTextController,
                    itemCount: coffees.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final opacity =
                          (1 - (index - _textPage.abs())).clamp(0.0, 1.0);

                      return Opacity(
                          opacity: opacity,
                          child: Text(
                            coffees[index].name,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ));
                    }),
              ),
              SizedBox(height: 15,),
              AnimatedSwitcher(
                duration: _duration,
                child: Text(
                    '\$${coffees[_currentPage.toInt()].price.toStringAsFixed(2)}'),
              )
            ]),
            top: 0,
            left: 0,
            right: 0,
            height: 100,
          ),
        ],
      ),
    );
  }
}
