import { Template } from 'meteor/templating';
 
import { Dogs } from '../api/tasks.js';
 
import './body.html';
 
Template.body.helpers({
  dogs() {
    return Dogs.find({}, { sort: { createdAt: -1 } });
  },
});
Template.body.events({
  'click #search-btn':function(){
    $("#search-dog").show();
    $("#add-dog").hide();
  },
  'click #add-btn':function(){
    $("#search-dog").hide();
    $("#add-dog").show();
  },
  'submit #new-dog'(event) {
    // Prevent default browser form submit
    event.preventDefault();
 
    // Get value from form element
    const target = event.target;
    const name = target.name.value;
    const breed = target.breed.value;
    const weight = target.weight.value;
    const color = target.color.value;
 
    // Insert a task into the collection
    Dogs.insert({
      name: name,
      breed: breed,
      weight: weight,
      color: color,
      createdAt: new Date(), // current time
    });
 
    // Clear form
    target.name.value = '';
    target.breed.value = '';
  },
  'submit #search-dog'(event) {
    // Prevent default browser form submit
    event.preventDefault();
 
    // Get value from form element
    const target = event.target;
    const breed = target.breed.value;
    const weight = target.weight.value;
    const color = target.color.value;
 
    // Insert a task into the collection
    var dogs = Dogs.find({}, { sort: { createdAt: -1 } }).fetch();
 

  },
});