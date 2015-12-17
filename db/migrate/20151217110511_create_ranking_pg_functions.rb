class CreateRankingPgFunctions < ActiveRecord::Migration
  def up
    execute <<-SPROC
      CREATE OR REPLACE FUNCTION popularity(count integer, weight integer default 3) RETURNS integer AS $$
        SELECT count * weight
      $$ LANGUAGE SQL IMMUTABLE;

      CREATE OR REPLACE FUNCTION ranking(id integer, counts integer, weight integer default 3) RETURNS integer AS $$
        SELECT id + popularity(counts, weight)
      $$ LANGUAGE SQL IMMUTABLE;

      CREATE INDEX index_projects_on_ranking
        ON projects (ranking(id, votes_count, 3) DESC);
    SPROC
  end

  def down
    execute <<-SPROC
      DROP INDEX index_projects_on_ranking;
      DROP FUNCTION IF EXISTS popularity(integer, integer);
      DROP FUNCTION IF EXISTS ranking(integer, integer, integer);
    SPROC
  end
end
