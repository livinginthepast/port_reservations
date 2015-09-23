port_reservations
=================

Use data bags in Chef to manage specific application port reservations.

## Usage

### Data bag

Create a json file for your port reservations.

```bash
mkdir -p data_bags/ports
touch data_bags/ports/reservations.json
```

```json
{
  "id": "reservations",
  "mapping": {
    "my-app": 8000,
    "haproxy-for-my-app": 8001
  }
}
```

In order to reserve a range of ports, strings can be used:

```json
{
  "id": "reservations",
  "mapping": {
    "my-app": 8000,
    "haproxy-for-my-app": 8001
    "redii": "30000..30012"
  }
}
```

Note that when in this case, a range is returned by the included helpers.


### Helpers

In a recipe, you can use the `PortReservation` helper to retrieve a specific port.

```ruby
include_recipe 'port_reservations'

PortReservation.for('my-app') == 8000
PortReservation.for('redii') == 30000..30012
```

