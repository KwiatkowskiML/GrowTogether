from Models import EventModel

if __name__ == "__main__":
    event = EventModel(eventTitle="Test Event",
                       eventOwnerName="Test Owner",
                       eventOwnerId=1,
                       eventGoal=100.0,
                       eventCurrentMoney=0.0,
                       eventContributionsNumber=0,
                       eventLat=0.0,
                       eventLon=0.0,
                       eventDesc="Test Description",
                       eventStartDate="2022-01-01T00:00:00",
                       eventEndDate="2022-01-02T00:00:00",
                       eventOwnerContactMail="adam@gmail.com",
                       eventBenefitDesc="Test Benefit")

    print(event.model_dump_json(indent=2))
