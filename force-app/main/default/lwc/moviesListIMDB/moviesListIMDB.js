import { LightningElement, wire } from 'lwc';
import getMovies from '@salesforce/apex/iMDB_Controller.getMovies';




export default class MoviesListIMDB extends LightningElement {
    enteredText = '';  // Changed from enteredTest to enteredText
    searchText = '';
    showText = 'Please Enter a valid Movie Name';  // Fixed typo "Nmae"
    movies = [];  // Declare movies


    handleOnChange(event) {
    
        this.enteredText = event.target.value; 
    }

    handleOnClick(event) {
        this.searchText = this.enteredText;
        console.log('Search Text:', this.searchText);
    }

    @wire(getMovies, { searchText: '$searchText'})
    fetchMovies(result) {
        console.log('Wire Result:', result);  
        if (result.data) {
            let data = JSON.parse(result.data);

            if (data.success) {
                this.movies = data.result;
                this.showText = '';
            } else {
                this.movies = [];
                this.showText = 'Please Enter a valid Movie Name';  
            }
        } else if (result.error) {
            console.log('Error occurred while searching movies:', result.error);  // Fixed logging issue
            this.showText = 'Error occurred while searching movies: ' + result.error;
        }
    }
}