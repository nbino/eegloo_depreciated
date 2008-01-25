// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
Effect.SlideLeft = function(element) {
  element = $(element);
  Element.cleanWhitespace(element);
  var oldInnerRight = Element.getStyle(element.firstChild, 'right');
  return new Effect.Scale(element, 0, 
   Object.extend({ scaleContent: false, 
    scaleY: false, 
    scaleMode: 'box',
    scaleFrom: 100,
    restoreAfterFinish: true,
    beforeStartInternal: function(effect) { with(Element) {
      makePositioned(effect.element);
      makePositioned(effect.element.firstChild);
      if(window.opera) setStyle(effect.element, {top: ''});
      makeClipping(effect.element);
      show(element); }},  
    afterUpdateInternal: function(effect) { with(Element) {
      setStyle(effect.element.firstChild, {right:
        (effect.dims[0] - effect.element.clientWidth) + 'px' }); }},
    afterFinishInternal: function(effect) { with(Element) {
        [hide, undoClipping].call(effect.element); 
        undoPositioned(effect.element.firstChild);
        undoPositioned(effect.element);
        setStyle(effect.element.firstChild, {right: oldInnerRight}); }}
   }, arguments[1] || {})
  );
}

Effect.SlideLeft = function(element) {
  element = $(element);
  Element.cleanWhitespace(element);
  var oldInnerRight = Element.getStyle(element.firstChild, 'right');
  return new Effect.Scale(element, 0, 
   Object.extend({ scaleContent: false, 
    scaleY: false, 
    scaleMode: 'box',
    scaleFrom: 100,
    restoreAfterFinish: true,
    beforeStartInternal: function(effect) { with(Element) {
      makePositioned(effect.element);
      makePositioned(effect.element.firstChild);
      if(window.opera) setStyle(effect.element, {top: ''});
      makeClipping(effect.element);
      show(element); }},  
    afterUpdateInternal: function(effect) { with(Element) {
      setStyle(effect.element.firstChild, {right:
        (effect.dims[0] - effect.element.clientWidth) + 'px' }); }},
    afterFinishInternal: function(effect) { with(Element) {
        [hide, undoClipping].call(effect.element); 
        undoPositioned(effect.element.firstChild);
        undoPositioned(effect.element);
        setStyle(effect.element.firstChild, {right: oldInnerRight}); }}
   }, arguments[1] || {})
  );
}