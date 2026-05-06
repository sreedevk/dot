{
  user = {
    tags = [
      {
        name = "important";
        coefficient = 15.0;
      }
      {
        name = "later";
        coefficient = -10.0;
      }
      {
        name = "somday";
        coefficient = -15.0;
      }
    ];
    projects = [
      {
        name = "learn:tech";
        coefficient = 5.0;
      }
      {
        name = "blog";
        coefficient = 5.0;
      }
      {
        name = "opensource";
        coefficient = 5.0;
      }
      {
        name = "personal:homenet";
        coefficient = 5.0;
      }
      {
        name = "work";
        coefficient = 8.0;
      }
      {
        name = "other";
        coefficient = 4.0;
      }
    ];
  };

  system = {
    due = 12.0;
    blocking = 2.0;
    scheduled = 5.0;
    active = 4.0;
    age = 2.0;
    annotations = 1.0;
    tags = 1.0;
    project = 1.0;
    waiting = -3.0;
    blocked = -5.0;
  };
  uda = {
    H = 6.0;
    M = 3.9;
    L = 1.8;
  };
}
