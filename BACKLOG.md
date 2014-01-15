# Backlog Transition Net

## Do not forget to...

- Use `build_stubbed` method to create test data whenever possible!
  - Make sure that relationships are also created using the selected build/create strategy, see http://stackoverflow.com/questions/13308768!
- Use `it { should accept_nested_attributes_for :bla }` in specs!
- Add git hook to automatically execute rip_hashrocket
- Add git hook to automatically execute rails_best_practices
- Add git hook to automatically execute rubocop
- Add source maps for [CoffeeScript](https://github.com/markbates/coffee-rails-source-maps/) and [Sass](https://github.com/vhyza/sass-rails-source-maps) (both gems seem not to work at the moment)

## Known issues

- Guard config doesn't properly reload after change (manual restart needed), see https://github.com/guard/guard/issues/540
- validate_uniqueness_of needs an existing record at the moment but should be optimized in future, see https://github.com/thoughtbot/shoulda-matchers/issues/194