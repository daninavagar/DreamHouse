@isTest
global class ParkServiceMock implements WebServiceMock {

    global void doInvoke(
        Object stub,
        Object request,
        Map<String,Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String requestNS,
        String responseName,
        String responseType   
    ) {
        ParkService.byCountryResponse mockResponse = new ParkService.byCountryResponse();

        ParkService.byCountry countryRequest = (ParkService.byCountry) request;
        String country = countryRequest.arg0;

        String[] parksList = getParksForCountry(country);

        mockResponse.return_x = parksList;
        response.put('response_x', mockResponse);
    }

    private String[] getParksForCountry(String country) {
        Map<String, String[]> countryParks = new Map<String,String[]>{
            'Germany' => new String[]{
                'Black Forest National Park',
                'Bavarian Forest National Park',
                'Saxon Switzerland National Park',
                'Wadden Sea National Park'
            },
            'India' => new String[]{
                'Jim Corbett National Park',
                'Kaziranga National Park',
                'Kanha National Park',
                'Bandhavgarh National Park',
                'Ranthambore National Park'
            },
            'Japan' => new String[]{
                'Fuji-Hakone-Izu National Park',
                'Nikko National Park',
                'Yoshino-Kumano National Park',
                'Akan-Mashu National Park',
                'Daisetsuzan National Park'
            },
            'United States' => new String[]{
                'Yellowstone National Park',
                'Grand Canyon National Park',
                'Yosemite National Park',
                'Great Smoky Mountains National Park',
                'Zion National Park',
                'Rocky Mountain National Park'
            }
        };

        if (countryParks.containsKey(country)) {
            return countryParks.get(country);
        } else {
            return new String[]{'No parks found for ' + country};
        }
    }
}