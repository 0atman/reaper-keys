local cmd = require('command.output')

return {
  {
    { 'timeline_operator' },
    function(state, timeline_operator)
      return state
    end
  },
  {
    { 'timeline_motion' },
    function(state, timeline_motion)
      return state
    end
  },
  {
    { 'number', 'timeline_motion' },
    function(state, number, timeline_motion)
      return state
    end
  },
  {
    { 'command' },
    function(state, action)
      return state
    end
  },
  {
    { 'number', 'command' },
    function(state, number, action)
      return state
    end
  },
}
