import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

@immutable
class MovieAppState {
  final int count;

  MovieAppState({
    @required this.count,
  });

  factory MovieAppState.initial() {
    return MovieAppState(count: 0);
  }

  Map<String, dynamic> toJson() => {
    'count': this.count
  };
}

class IncrementCounterAction {
  final int incrementAmount;
  IncrementCounterAction(this.incrementAmount);
}

class GetMoviesAction {
}

class GetMoviesSuccessAction {

}

int counterReducer(int state, dynamic action) {
  if (action is IncrementCounterAction) {
    return state + action.incrementAmount;
  }
  return state;
}

dynamic movieReducer()

MovieAppState movieAppReducer(MovieAppState appState, dynamic action) {
  return MovieAppState(
    count: counterReducer(appState.count, action)
  );
}

final movieAppStore = new Store<MovieAppState>(movieAppReducer, initialState: MovieAppState.initial());

