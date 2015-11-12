var Tooltips = {
	opened: false,
    current: null,
	toggleTooltips : function (object){
      if(this.opened){
        this.closeTooltips(this.current.parentNode.childNodes[1].childNodes[0]);
      }
      if(!this.opened){
			var text = object.getAttribute('title');
			div = document.createElement('div');
			div.setAttribute('class', 'ttips-box');
			p = document.createElement('p');
			p.innerHTML=text;
			a = document.createElement('a');
			a.innerHTML="&times;";
			a.setAttribute('onclick', 'Tooltips.closeTooltips(this)');
			a.setAttribute('class', 'times');
			div.appendChild(p);
			div.appendChild(a);
			object.parentElement.appendChild(div);
			this.opened = true;
            this.current = object;
		}
	},
	closeTooltips: function(object){
		object.parentElement.remove();
		this.opened = false;
	}
}