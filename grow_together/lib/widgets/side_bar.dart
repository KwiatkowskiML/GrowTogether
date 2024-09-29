import 'package:flutter/material.dart';
import 'package:grow_together/conn/api_calls.dart';
import 'package:grow_together/models/user_request.dart';
import 'package:grow_together/user.dart';
import '../models/event.dart';
import '../models/event_pay.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool _isExpanded = false;
  int _currentPage = 0;
  List<EventPay> _eventPays = [];
  List<Event> _events = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: _isExpanded ? 0 : -280,
          top: 0,
          bottom: 0,
          child: MouseRegion(
            onEnter: (_) => _setVisibleTrue(),
            onExit: (_) => setState(() => _isExpanded = false),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(-5, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildTabBar(),
                  Expanded(child: _buildContent()),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: MouseRegion(
            onEnter: (_) => _setVisibleTrue(),
            child: Container(
              width: 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.withOpacity(0.3), Colors.blue.withOpacity(0.1)],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.blue,
      child: Row(
        children: [
          Icon(Icons.dashboard, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'Dashboard',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.blue.shade50,
      child: Row(
        children: [
          Expanded(child: _buildTab('Event Pays', 0)),
          Expanded(child: _buildTab('Events', 1)),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() => _currentPage = index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _currentPage == index ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _currentPage == index ? Colors.blue : Colors.black54,
            fontWeight: _currentPage == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return _currentPage == 0 ? _buildEventPaysPage() : _buildEventsPage();
  }

  Future<void> _setVisibleTrue() async {
    setState(() => _isExpanded = true);
    _fetchData();
  }

  Future<void> _fetchData() async {
    final userId = UserSingleton().token;
    if (userId != null) {
      final events = await ApiCalls.GetUserEvent(UserRequest(userId: userId));
      final eventPays = await ApiCalls.GetUserPays(UserRequest(userId: userId));
      setState(() {
        _events = events;
        _eventPays = eventPays;
      });
    }
  }

  Widget _buildEventPaysPage() {
    return ListView.builder(
      itemCount: _eventPays.length,
      itemBuilder: (context, index) {
        final eventPay = _eventPays[index];
        return ListTile(
          title: Text(eventPay.eventName),
          subtitle: Text('User ID: ${eventPay.userId}'),
          trailing: Text('\$${eventPay.eventAmount.toStringAsFixed(2)}'),
        );
      },
    );
  }

  Widget _buildEventsPage() {
    return ListView.builder(
      itemCount: _events.length,
      itemBuilder: (context, index) {
        final event = _events[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.eventTitle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Organizer: ${event.eventOwnerName}'),
                SizedBox(height: 4),
                Text('Goal: \$${event.eventGoal.toStringAsFixed(2)}'),
                SizedBox(height: 4),
                Text('Raised: \$${event.eventCurrentMoney.toStringAsFixed(2)}'),
                SizedBox(height: 4),
                Text('Contributions: ${event.eventContributionsNumber}'),
                SizedBox(height: 8),
                Text('${_formatDate(event.eventStartDate)} - ${_formatDate(event.eventEndDate)}'),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }
}