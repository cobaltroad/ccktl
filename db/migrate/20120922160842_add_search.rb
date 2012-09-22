class AddSearch < ActiveRecord::Migration
  def up
    execute "CREATE INDEX docs_index ON docs USING GIN(vector);"

    execute <<-EOSQL
      CREATE FUNCTION vector_update() RETURNS TRIGGER AS $$
      BEGIN
        NEW.vector = to_tsvector('pg_catalog.english', CAST(avals(NEW.data) AS text));
        RETURN NEW;
      END
      $$ LANGUAGE 'plpgsql';
      CREATE TRIGGER vector_trigger BEFORE INSERT OR UPDATE ON docs
      FOR EACH ROW EXECUTE PROCEDURE vector_update();
    EOSQL
  end

  def down
    execute "DROP TRIGGER vector_trigger ON docs;"
    execute "DROP FUNCTION vector_update();"
    execute "DROP INDEX docs_index;"
  end
end
