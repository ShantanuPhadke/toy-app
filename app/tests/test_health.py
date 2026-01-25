import unittest
from fastapi.testclient import TestClient
from app.main import app

class TestHealth(unittest.TestCase):
    def setUp(self):
        self.client = TestClient(app)

    def test_health(self):
        r = self.client.get("/health")
        self.assertEqual(r.status_code, 200)
        self.assertEqual(r.json(), {"ok": True})

if __name__ == "__main__":
    unittest.main()

