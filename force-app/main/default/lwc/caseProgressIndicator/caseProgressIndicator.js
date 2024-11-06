import { LightningElement, wire, api } from 'lwc';
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import CASE_OBJECT from '@salesforce/schema/Case';
import STATUS_FIELD from '@salesforce/schema/Case.Status';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';
import {
    subscribe,
    unsubscribe,
    onError,
    setDebugFlag,
    isEmpEnabled,
} from 'lightning/empApi';

export default class CaseProgressIndicator extends LightningElement {
    @api recordId;
    statusOptions = [];
    caseStatusValue;
    channelName = '/event/Test__e';
    subscription = {};

    // Obtenir les informations de l'objet Case
    @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
    objectInfo;

    // Récupérer les valeurs de la liste de sélection pour le champ Status
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: STATUS_FIELD })
    picklistFunction({ data, error }) {
        if (data) {
            console.log('Picklist values:', data);
            this.statusOptions = data.values;
        } else if (error) {
            console.error("Erreur lors de la récupération des valeurs de la liste de sélection:", error);
        }
    }

    // Obtenir la valeur actuelle de Status pour le cas
    @wire(getRecord, { recordId: '$recordId', fields: [STATUS_FIELD] })
    getRecordOutput({ data, error }) {
        if (data) {
            this.caseStatusValue = getFieldValue(data, STATUS_FIELD);
            console.log('Valeur actuelle de caseStatusValue:', this.caseStatusValue); // Afficher la valeur
        } else if (error) {
            console.error("Erreur lors de la récupération du statut du cas:", error);
        }


    }

          // Initializes the component
          connectedCallback() {
            this.handleSubscribe();
            // Register error listener
            this.registerErrorListener();
          }    
     // Handles subscribe button click
     handleSubscribe() {
        // Callback invoked whenever a new event message is received
        // const messageCallback = function (response) {
        //     console.log('New message received: ', JSON.stringify(response));
        //     // Response contains the payload of the new message received
        // };

        const messageCallback =(response) =>{
           console.log('New message received: ', JSON.stringify(response));
           this.handleEventResponse(response);
        }

        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe(this.channelName, -1, messageCallback).then((response) => {
            // Response contains the subscription information on subscribe call
            console.log(
                'Subscription request sent to: ',
                JSON.stringify(response.channel)
            );
            this.subscription = response;
        });
    }
    
   
    disconnectedCallback(){
        unsubscribe(this.subscription, (response) => {
            console.log('unsubscribe() response: ', JSON.stringify(response));
            // Response is true for successful unsubscribe
        });
    }

    registerErrorListener() {
    // Invoke onError empApi method
     onError((error) => {
        console.error('Erreur reçue depuis le serveur: ', JSON.stringify(error));
        if (error && error.message) {
            console.error("Détails de l'erreur de connexion:", error.message);
        }
     });
   }

  // Vérification de la réponse d'événement avec log supplémentaire
   handleEventResponse(response) {
     if (response && response.data) {
        console.log('Données de réponse reçues:', JSON.stringify(response.data));
     } else {
        console.error('Aucune donnée dans la réponse d\'événement');
    }
 }
   



}